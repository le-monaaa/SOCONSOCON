package site.soconsocon.auth.service;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import site.soconsocon.auth.domain.dto.request.DepositRequestDto;
import site.soconsocon.auth.domain.dto.request.WithdrawRequestDto;
import site.soconsocon.auth.domain.entity.jpa.Member;
import site.soconsocon.auth.exception.AccountException;
import site.soconsocon.auth.exception.ErrorCode;
import site.soconsocon.auth.exception.MemberException;
import site.soconsocon.auth.repository.MemberRepository;

@Service
@RequiredArgsConstructor
public class AccountService {

    private final MemberRepository memberRepository;

    /**
     * 입금
     *
     * @param depositRequestDto
     * @throws MemberException
     */
    @Transactional
    public String deposit(DepositRequestDto depositRequestDto) throws MemberException, AccountException {
        Member member = memberRepository.findMemberById(depositRequestDto.getMemberId()).orElseThrow(
                () -> new MemberException(ErrorCode.USER_NOT_FOUND)
        );
        int depositMoney = depositRequestDto.getMoney(); //충전할 소콘머니

        try {
            memberRepository.chargeSoconMoney(depositRequestDto.getMemberId(), depositMoney); // 증가
            // 입금이 성공했다는 결과를 보냄
            return "소콘머니가 충전되었습니다.";

        } catch (Exception e) {
            // 입금이 실패했다는 결과를 보냄
            throw new AccountException(ErrorCode.DEPOSIT_FAIL);
        }

    }

    /**
     * 출금
     *
     * @param withdrawRequestDto
     * @throws MemberException
     * @throws AccountException
     */

    @Transactional
    public String withdraw(WithdrawRequestDto withdrawRequestDto) throws MemberException, AccountException {
        Member member = memberRepository.findMemberById(withdrawRequestDto.getMemberId()).orElseThrow(
                () -> new MemberException(ErrorCode.USER_NOT_FOUND)
        );
        int soconMoney = member.getSoconMoney(); //현재 보유하고 있는 소콘머니
        int depositMoney = withdrawRequestDto.getMoney(); //출금할 소콘머니
        String soconPassword = member.getSoconPassword();
        String inputPassword = withdrawRequestDto.getSoconPassword(); //사용자가 입력한 비밀번호

        //소콘 비밀번호 맞지 않음
        if (!soconPassword.equals(inputPassword)) {
            throw new AccountException(ErrorCode.NOT_MATCH_PASSWORD);
        }
        //돈 없음
        if (soconMoney < depositMoney) {
            throw new AccountException(ErrorCode.NO_MONEY);
        }

        try {
            memberRepository.withdrawSoconMoney(withdrawRequestDto.getMemberId(), depositMoney); //출금
            return "소콘머니가 출금되었습니다.";

        } catch (Exception e) {
            // 출금이 실패했다는 결과를 보냄
            throw new AccountException(ErrorCode.WITHDRAW_FAIL);
        }

    }

}
